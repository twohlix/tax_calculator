class ProgressiveTaxer

  def initialize opts = {}
    @taxes = Array.new
    taxes_from_file opts[:filename] if opts.has_key? :filename
  end

  def taxes_from_file filename
    tax_file = File.new(filename, 'r')

    while(line = tax_file.gets)
      possible_tax = line.strip.split
      next if possible_tax.length != 2
      add_tax possible_tax[0].to_f, possible_tax[1].to_f
    end

    tax_file.close
  end

  # Adds a tax for a minimum income level\
  # Overwrites an equal tax min_income
  def add_tax min_income, rate
    return false if min_income.nil?
    return false if rate.nil?

    new_tax = {min_income: min_income, rate: rate}

    # find the insertion point for the new tax
    index_to_insert_after = nil
    @taxes.each_index do |index|
      if @taxes[index][:min_income] <= min_income
        index_to_insert_after = index
      end
    end

    # empty taxes case
    if index_to_insert_after.nil?
      @taxes.insert 0, new_tax
      return true
    end

    # compare the equal case
    old_tax = @taxes[index_to_insert_after]
    if old_tax[:min_income] == new_tax[:min_income]
      @taxes[index_to_insert_after] = new_tax
    else
      @taxes.insert index_to_insert_after+1, new_tax
    end

    return true
  end

  # returns the tax on an income given this tax table
  def tax income
    income = 0 if income.nil?
    income = income.to_f if income.kind_of? String

    total_tax = 0
    working_income = income
    @taxes.reverse.each do |tax|
      if working_income >= tax[:min_income]
        diff = working_income - tax[:min_income]
        total_tax += diff*tax[:rate]
        working_income -= diff
      end
    end

    return total_tax
  end

end 

