#!/usr/bin/env ruby

require 'newsrc'

describe Newsrc do
  it "should not parse a blank .newsrc file" do
    expect { 
      Newsrc.new("")
    }.to raise_error(ArgumentError, "The file supplied can't be read")
  end

  let(:newsrc) { Newsrc.new('spec/newsrc') }
  
  it "should list a subscribed group" do
    newsrc.list.should match(/^comp\.lang\.ruby$/)
  end

  it "should list subscribed groups" do
    newsrc.list.should match(/^comp\.lang\.ruby$/)
    newsrc.list.should match(/^gnu\.emacs\.help$/)
  end


  it "should not list non subscribed groups" do
    newsrc.list.should match(/^comp\.lang\.ruby$/)
    newsrc.list.should match(/^gnu\.emacs\.help$/)
    newsrc.list.should_not match(/^alt\.test$/)
  end

  it "should find a group" do
    newsrc.find('comp.lang.ruby').should be_true
    newsrc.find('gnu.emacs.help').should be_true
  end

  it "should not find groups" do
    newsrc.find('blah.blah').should be_false
    newsrc.find('fake group').should be_false
    newsrc.find('comp').should be_false
    newsrc.find('gnu.emacs.hel').should be_false 
    #                  no 'p' ^ here
    # newsrc.find('alt.test! 1-41828').should be_true
  end
  
  it "should return the list of read articles" do
    newsrc.read_articles('comp.lang.ruby').should match(/1-37142,37209-37210,37213-37214,37232,37255-37257,37259,37261,37278-37279,37293,37298,37312,37316,37338-37339,37346-37347,37358-37359,37397,37441,37445-37446,37453-37454,37457-37460,37463-37464,37512,37549,37573,37577,37580-37581,37587,37620-37621,37624,37628,37701,37705,37712,37720,37739-37744,37746-37748,37784,37788,37895,37903,37915,37921,37938,37961,37970,38076-38077,38084,38086-38087/)
  end

  it "should return blank list for read articles of a non subscribed group" do
    newsrc.read_articles('de.comp.lang.ruby').should match("")  
  end

end
