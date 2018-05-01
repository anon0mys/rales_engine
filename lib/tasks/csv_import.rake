require 'csv'

namespace :db do
  namespace :seed do

    desc 'import all csv'
    task :all => :environment do
      Rake::Task['db:seed:merchants'].invoke
      Rake::Task['db:seed:customers'].invoke
      Rake::Task['db:seed:items'].invoke
      Rake::Task['db:seed:invoices'].invoke
      Rake::Task['db:seed:invoice_items'].invoke
      Rake::Task['db:seed:transactions'].invoke
    end

    desc 'import merchants'
    task :merchants => :environment do
      CSV.foreach('data/merchants.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        Merchant.create!(row.to_hash)
      end
      puts "Seeded Merchants"
    end

    desc 'import customers'
    task :customers => :environment do
      CSV.foreach('data/customers.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        Customer.create!(row.to_hash)
      end
      puts "Seeded Customers"
    end

    desc 'import items'
    task :items => :environment do
      CSV.foreach('data/items.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        Item.create!(row.to_hash)
      end
      puts "Seeded Items"
    end

    desc 'import invoices'
    task :invoices => :environment do
      CSV.foreach('data/invoices.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        Invoice.create!(row.to_hash)
      end
      puts "Seeded Invoices"
    end

    desc 'import invoice items'
    task :invoice_items => :environment  do
      CSV.foreach('data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        InvoiceItem.create!(row.to_hash)
      end
      puts "Seeded Invoice Items"
    end

    desc 'import transactions'
    task :transactions => :environment  do
      CSV.foreach('data/transactions.csv', headers: true, header_converters: :symbol, converters: :numeric) do |row|
        Transaction.create!(id:                 row[:id],
                            invoice_id:         row[:invoice_id],
                            credit_card_number: row[:credit_card_number],
                            result:             row[:result],
                            created_at:         row[:created_at],
                            updated_at:         row[:updated_at])
      end
      puts "Seeded Transactions"
    end

  end
end
