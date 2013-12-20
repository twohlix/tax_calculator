def usage_check args
  if args.length < 2
    puts "usage: #{$0} tax-table income"
    puts "\texample: #{$0} federal.taxes 153000"
    exit 0
  end
end

usage_check ARGV

require_relative 'progressive_taxer'

tax_filename = ARGV[0]
income = ARGV[1].to_f

taxes = ProgressiveTaxer.new filename: tax_filename

puts taxes.tax income