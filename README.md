# Rails-Engine


Rails-Engine is a solo Rails-API project for the purposes of exposing data to an application through an API that the front end will consume.

Learning goals 

- Expose an API
- Use serializers to format JSON responses
- Test API exposure
- Use SQL and ActiveRecord to gather data

This project has been created using Ruby version 2.7.2 and Rails version 5.2.6

Gems Utilized

- RSpec
- Pry
- jsonapi-serializer
- factorybot rails
- faker

## What's Left?
- Controller refactoring 
- Rearrange search controllers to adhere more to REST
- Remove associations with and delete invoices that only contain one item upon deletion of an item
- Add additional search feature to find items based on minimum and maximum prices
