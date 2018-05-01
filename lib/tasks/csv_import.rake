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
      read_csv('data/merchants.csv', Merchant)
      puts "Seeded Merchants"
    end

    desc 'import customers'
    task :customers => :environment do
      read_csv('data/customers.csv', Customer)
      puts "Seeded Customers"
    end

    desc 'import items'
    task :items => :environment do
      read_csv('data/items.csv', Item)
      puts "Seeded Items"
    end

    desc 'import invoices'
    task :invoices => :environment do
      read_csv('data/invoices.csv', Invoice)
      puts "Seeded Invoices"
    end

    desc 'import invoice items'
    task :invoice_items => :environment  do
      read_csv('data/invoice_items.csv', InvoiceItem)
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

    def read_csv(file_path, model)
      CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric) do |row|
        model.create!(row.to_hash)
      end
    end
  end
end
