require 'rails_helper'

describe Pledge do
  let( :pledge ) { Pledge.new }

  describe 'validations' do
    it 'should validate presence of name' do
      expect( pledge ).not_to be_valid
      expect( pledge.errors[ :name ] ).to include( "can't be blank" )
    end

    it 'should validate presence of email' do
      expect( pledge ).not_to be_valid
      expect( pledge.errors[ :email ] ).to include( "can't be blank" )
    end

    it 'should validate email format' do
      pledge_with_valid_email_format = Pledge.new email: 'foo@bar'
      pledge_with_invalid_email_format = Pledge.new email: 'foobar'

      expect( pledge_with_valid_email_format ).not_to be_valid
      expect( pledge_with_valid_email_format.errors[ :email ] ).not_to include( 'is invalid' )
      expect( pledge_with_invalid_email_format ).not_to be_valid
      expect( pledge_with_invalid_email_format.errors[ :email ] ).to include( 'is invalid' )
    end

    it 'should validate email is unique' do
      pledge1 = Pledge.create name: 'first', email: 'foo@bar'
      pledge2 = Pledge.new name: 'second', email: 'foo@bar'


      expect( pledge2 ).not_to be_valid
      expect( pledge2.errors[ :email ] ).to include( 'has already been taken' )
      expect( Pledge.count ).to eql( 1 )
      expect( Pledge.first.name ).to eql( 'first' )
    end
  end

  describe 'class methods' do
    describe '.counter' do
      it 'should get pledge count from Redis' do
        Redis.new.set 'pledges:counter', 10
        expect( Pledge.counter ).to eql( '10' )
      end
    end
  end
end