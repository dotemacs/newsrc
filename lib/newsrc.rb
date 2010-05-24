
class Newsrc

  def initialize(path)
    raise ArgumentError, "The file supplied can't be read"  if path.eql?('')
    # @newsrc = File.open(path, "r+")
    file = File.open(path, "r+")

    @newsrc = []
    # @news << file.readlines
    file.each do |line|
      @newsrc << line
    end
    # puts @news.to_s
    # @news
  end

  def list
    # @newsrc.readlines.each do |group|
    #   return group.to_s.gsub(/\:.*/, "")
    # end
    # @newsrc.readlines.to_s.gsub(/\:.*/, "")
    @newsrc.to_s.gsub(/\:.*/, "")
  end

  def subscribed
    # @newsrc.readlines.to_s.match(/.*!/).gsub(/\:.*/, "")
    @newsrc.to_s.match(/.*!/).gsub(/\:.*/, "")
  end

  def find(group)
    @newsrc.each do |g|
      if g.gsub(/:.*/, "") =~ /^#{group}$/
        return true
        exit
      end
    end

    false 
  end

  def read_articles(group)
    if find(group)
      @newsrc.grep(/#{group}:\ ([1-9,-]+)/).to_s.split(/:\ /)[1]
    else
      ""
    end
  end

end
