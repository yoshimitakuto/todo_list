# frozen_string_litaral: true

require 'rails_helper'

RSpec.describe Task, type: :system do
  let!(:task) { create(:task, title:'hoge',body:'body') }

  describe '一覧画面について' do
    before do
      visit tasks_path
    end

    describe '#index' do
      it 'bodyの内容が表示されているか' do
        expect(page).to have_content task.body
      end

      it 'ユーザー編集リンクが存在しているか' do
        expect(page).to have_link href: "edit_user_path(current_user)"
      end

      it '投稿編集画面へのリンクが表示されているか' do
        expect(page).to have_link '編集', href: " /tasks/#{task.id}/edit"
      end
    end

  end

end