class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :address
  validates :delivery, inclusion: { in: [true, false] }

  aasm do
    state :basket, :initial => true
    state :ordered
    state :paid
    state :completed
    state :cancelled

    event :order do
      transitions :from => :basket, :to => :ordered
    end

    event :pay do
      transitions :from => :ordered, :to => :paid, before_enter: :erase_current_order
    end

    event :complete do
      transitions :from => :paid, :to => :completed
    end

    event :cancel do
      transitions :from => [:basket, :ordered, :paid], :to => :cancelled
    end
  end

  def pay_in_store?
    ccn == nil && expdate == nil
  end

  def add_item(item)
    if self.items.include?(item)
      access_order_item(item).increment!(:quantity)
    else
      self.items << item
    end
  end

  def remove_item(item)
    self.items.delete(item)
  end

  def empty?
    items.empty?
  end

  def total
    order_items.reduce(0) do |sum, order_item|
      sum += order_item.quantity * order_item.item.price
    end
  end


  def total_for_humans
    sprintf("%.2f",(total.to_f/100))
  end

  def tax
    total * 0.08
  end

  def tax_for_humans
    sprintf("%.2f",(tax.to_f/100))
  end

  def total_price
    total + tax
  end

  def total_price_for_humans
    sprintf("%.2f",(total_price.to_f/100))
  end

  def arrival_time
    (updated_at + 45.minutes).strftime('%l:%M %p')
  end

  private

  def access_order_item(item)
    self.order_items.where(item_id: item.id).first
  end
end
