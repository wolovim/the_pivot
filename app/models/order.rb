class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  validates :delivery, presence: true

  aasm do
    state :basket, :initial => true
    state :ordered
    state :paid
    state :completed

    event :ordered do
      transitions :from => :basket, :to => :ordered
    end

    event :paid do
      transitions :from => :ordered, :to => :paid
    end

    event :completed do
      transitions :from => :paid, :to => :completed
    end

    event :cancelled do
      transitions :from => [:basket, :ordered, :paid, :completed], :to => :cancelled
    end
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

  def access_order_item(item)
    self.order_items.where(item_id: item.id).first
  end

  def empty?
    items.empty?
  end
end
