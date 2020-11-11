require 'rails_helper'

RSpec.describe Note, type: :model do
  # 検索文字列　に一致するメモを返すこと
  it "returns notes that match the search term" do
    user = User.create(
      first_name: 'Joe',
      last_name: 'Tester',
      email: "joetester@example.com",
      password: "hogehoge",
    )
    project = user.projects.create( name: "Test Project")
    note1 = project.notes.create(message: "This is the first note.", user: user,)
    note2 = project.notes.create(message: "This is the second note.", user: user,)
    note3 = project.notes.create(message: "First, preheat the oven.", user: user,)
    note4 = project.notes.create(message: "First, kore ha nihon no note.", user: user,)

    expect(Note.search("first")).to include(note1, note3)
    expect(Note.search("first")).to_not include(note2)
  end

  # 検索結果が１件も見つからなければ空のコレクションを返すこと
  it "returns an empty collection when no results are found" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "hogehoge"
    )

    project = user.projects.create(name: "Test Project")
    note1 = project.notes.create(message: "This is the first note.", user: user)
    note2 = project.notes.create(message: "This is the second note.", user: user)
    note3 = project.notes.create(message: "First, preheat the oven.", user: user,)
    expect(Note.search("message")).to be_empty
  end

  describe "search message for a term" do
    before do
      # 検索機能の全テスト関連する追加のテストデータをセットアップする
    end

    context "when a match is foudn" do
      # 一致する場合の examples
    end

    context "when no match is found" do
      # 一致しない場合の examples
    end
  end

# describe "クラスやシステムの機能に関するアウトライン" do
#   context "特定の状態に関するアウトライン" do
#     # examples
#   end
# end
end
