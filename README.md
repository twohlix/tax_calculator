Tax Calculator
==============

A simple command line progressive tax calculator.

Command Line usage
------------------

```bash
> ruby tax_calculator.rb tax-table income
```

```bash
> ruby tax_calculator.rb taxes/federal.2013.single.taxes 10000
1053.75
```

The calculator does not take into account deductions or anything specific to US income taxes. It is meant to be a generic progressive tax calculator.

ProgressiveTaxer class
----------------------
The ProgressiveTaxer class included does all the heavy lifting to calculate taxes and is easily used inside of other projects.

initializing from a filepath:
```ruby
taxer = ProgressiveTaxer.new filename: 'taxes/federal.2013.single.taxes'
income = 40000
tax_implication = taxer.tax income
```

creating a tax table on the fly:
```ruby
taxer = ProgressiveTaxer.new
# taxer.add_tax income-to-start-taxing-above tax-rate
taxer.add_tax 0, 0.05 # income above 0 is taxed at 5%
taxer.add_tax 3250, 0.08 # income above 3250 is taxed at 8%
taxer.add_tax 3250, 0.09 # income above 3250 is overwritten to be taxed at 9%
taxer.add_tax 10000, 0.01 # the rich get richer! income over 10000 is only taxed at 1%
taxer.add_tax 100, 0.12 # tax the poor until they get to 3250 income, order doesnt matter

taxer.tax 1 # = 0.05
```
