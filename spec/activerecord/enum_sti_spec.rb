require "test_helper"

RSpec.describe ActiveRecord::EnumSti do
  it "has a version number" do
    expect(ActiveRecord::EnumSti::VERSION).not_to be nil
  end

  describe "sti with customized inheritance_column" do
    before do
      @user = User.new
      @member = User::Member.create
      @admin = User::Admin.create
    end
    it "makes STI class" do
      expect(@user.class).to eq(User)
      expect(@member.class).to eq(User::Member)
      expect(@admin.class).to eq(User::Admin)
      expect(@member.my_role).to eq("member")
      expect(@admin.my_role).to eq("admin")
      expect(@member.role).to eq("member")
      expect(@admin.role).to eq("admin")
      expect(User.admin.last.class).to eq(User::Admin)
      expect(User.member.last.class).to eq(User::Member)
    end
  end

  describe "sti with basic inheritance_column" do
    before do
      @payment = Payment.new

      @credit_card = Payment::CreditCard.create
      @bank_transfer = Payment::BankTransfer.create
    end
    it "makes STI class" do
      expect(@payment.class).to eq(Payment)
      expect(@credit_card.class).to eq(Payment::CreditCard)
      expect(@bank_transfer.class).to eq(Payment::BankTransfer)
      expect(@credit_card.my_type).to eq("credit_card")
      expect(@bank_transfer.my_type).to eq("bank_transfer")
      expect(@credit_card.type).to eq("credit_card")
      expect(@bank_transfer.type).to eq("bank_transfer")
      expect(Payment.credit_card.last.class).to eq(Payment::CreditCard)
      expect(Payment.bank_transfer.last.class).to eq(Payment::BankTransfer)
    end
  end
end
