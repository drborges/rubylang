require 'rubylang'

RSpec.describe RubyLang do

  subject(:ruby) { RubyLang.new(double('http', get: 'response')) }

  it 'supports default parameters' do
    expect(ruby.pow(2)).to eq 4
    expect(ruby.pow(2, 3)).to eq 8
  end

  it 'supports keyword arguments' do
    expect(ruby.add(a: 3, b: 2)).to eq 5
  end

  it 'supports varargs on arrays' do
    expect(ruby.sum(1, 2, 3)).to eq 6
  end

  it 'supports splat operator on lists' do
    numbers = [1, 2, 3]
    expect(ruby.sum(*numbers)).to eq 6
  end

  it 'supports varargs on hashes' do
    expect(ruby.flatten(a: 1, b: 2, c: 3)).to eq [:a, 1, :b, 2, :c, 3]
  end

  it 'supports splat operator on hashes' do
    expect(ruby.flatten(**{a: 1, b: 2, c: 3})).to eq [:a, 1, :b, 2, :c, 3]
  end

  it 'supports lambdas' do
    counter = ruby.counter

    expect(counter.call).to eq 1
    expect(counter.call).to eq 2
    expect(counter.call).to eq 3
  end

  it 'support blocks' do
    reduced = ruby.reduce_range(0, 3) { |sum, n| sum + n }
    expect(reduced).to eq 6
  end

  it 'supports string interpolation' do
    expect(ruby.greet 'Diego').to eq 'Hello Diego!'
  end

  it 'supports conditional assignment (similar to JS)' do
    person ||= 'John'
    expect(ruby.greet person).to eq 'Hello John!'

    person ||= 'Diego'
    expect(ruby.greet person).to eq 'Hello John!'
  end

  it 'supports boolean semantics for pretty much any type' do
    zero = 0
    nil_obj = nil
    empty_str = ''
    empty_list = []
    empty_hash = {}

    expect(!zero).to eq false
    expect(!!nil_obj).to eq false
    expect(!empty_str).to eq false
    expect(!empty_list).to eq false
    expect(!empty_hash).to eq false
  end

  it 'supports parallel assignment' do
    a, b = 1, 2

    expect(a).to eq 1
    expect(b).to eq 2
  end

  it 'supports if blocks as expressions' do
    age = 30
    title = if age > 29
              'Sr.'
            else
              'Mr.'
            end

    expect(title).to eq('Sr.')
  end

  it 'supports case blocks as expressions' do
    age = 30
    title = case age
            when 0..17
              'Kid'
            when 18..29
              'Mr.'
            else
              'Sr.'
            end

    expect(title).to eq('Sr.')
  end

  it 'Supports default assignment operator' do
    title ||= 'Sr.'
    age = 30
    age ||= 15

    expect(title).to eq('Sr.')
    expect(age).to eq(30)
  end

  it 'mocks http client' do
    expect(ruby.http).to receive(:get).with('www.google.com')

    response = ruby.fetch 'www.google.com'

    expect(response).to eq('response')
  end
end
