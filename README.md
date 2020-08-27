# ActiveaRecord::EnumSti ![CI](https://github.com/suusan2go/activerecord-enum_sti/workflows/CI/badge.svg)

ActiveRecord::EnumSti is a library to use enum values as STI type.  

When you use enum, you might see the code like following.

```ruby
class Payment < ApplicationRecord
  enum kind: { credit_card: 0, bank_transfer: 10, paypal: 20 }

  def complete!
    if credit_card?
    # do something
    elsif bank_transfer?
    # do something
    elsif paypal?
    # do something
    end
  end

  def cancel!
    if credit_card?
    # do something
    elsif bank_transfer?
    # do something
    elsif paypal?
    # do something
    end
  end
end
```

In this code, we change the behavior according to the value of enum.
But if we can change the class by the value of enum, this code will be more clear.

This gem allows you to split the class using the Single Table Inheritance (STI) in Rails depending on the value of the enum.

```ruby
class Payment < ApplicationRecord
  include ActiveRecord::EnumSti
  enum type: { credit_card: 0, bank_transfer: 10, paypal: 20 }

  def complete!
    raise NotImplementedError
  end

  def cancel!
    raise NotImplementedError
  end
end

class Payment::CreditCard < Payment
  def complete!
    # do something for creditcard!
  end

  def cancel!
    # do something for creditcard!
  end
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-enum_sti'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-enum_sti

## Usage
First of all, include `ActiveRecord::EnumSti` in your enum defined class.

```ruby
class Payment < ApplicationRecord
  include ActiveRecord::EnumSti
  enum type: { credit_card: 0, bank_transfer: 10, paypal: 20 }
  # if you want to use the another column, you can use another enum column by below.
  # self.inheritance_column = :your_enum_column
end
```

Then, please define a class for each enum values. The class name should be `<SuperClass>::<camelized enum value>`

```ruby
class Payment::CreditCard < Payment
end
```

Now, you can use the value of enum for STI like below!

```
@credit_card = Payment::CreditCard.create
@credit_card.type
=> "credit_card"
Payment::CreditCard.all.to_sql
=> "SELECT \"payments\".* FROM \"payments\" WHERE \"payments\".\"type\" = 0"
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-enum_sti. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Activerecord::EnumSti project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/activerecord-enum_sti/blob/master/CODE_OF_CONDUCT.md).
