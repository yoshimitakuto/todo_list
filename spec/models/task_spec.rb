# frozen_string_litaral: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }
  it 'is valid with a valid title & body' do
    expect(task).to be_valid
  end
  it 'is not valid without title & body' do
    task.title = ''
    task.body = ''
    expect(task).to_not be_valid
  end
  it 'is not valid with title longer than 30 & body longer than 100' do
    task.title = Faker::Lorem.characters(number:31)
    task.body = Faker::Lorem.characters(number:101)
    expect(task).to_not be_valid
  end
end