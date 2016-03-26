class RubyLang
  attr_reader :http

  def initialize(http_client)
    @http = http_client
  end

  def pow(n, exp=2)
    n**exp
  end

  def add(a:, b:)
    return a + b
  end

  def sum(*numbers)
    numbers.reduce do |sum, n|
      sum + n
    end
  end

  def flatten(**hash)
    hash.flatten
  end

  def counter
    n = 0
    return -> { n += 1 }
  end

  def reduce_range(from, to)
    acc = 0
    (from..to).each { |n| acc = yield acc, n }
    acc
  end

  def greet person
    return "Hello #{person}!"
  end

  def fetch(url)
    @http.get url
  end
end
