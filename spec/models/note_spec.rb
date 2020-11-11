require 'rails_helper'

RSpec.describe Note, type: :model do
  before do
    # before(:each)  ... describe, context ブロック内の各テスト前に実行
    ## alias -> before(:example), before

    # before(:all)   ... describe, context Bロック内の全テストの前に一回だけ実行
    ## alias -> before(:context)

    # before(:suite) ... テストスイート全体の全ファイルを実行する前に実行される

    # 検索機能の全テスト関連する追加のテストデータをセットアップする

    @user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "hogehoge"
    )
    @project = @user.projects.create(name: "Tester project")
  end

  # ユーザー、プロジェクト、めっせーじがあれば有効な状態であること
  it "is valid with a user, project, and message" do
    note = Note.new(
      message: "This is a sample note.",
      user: @user,
      project: @project
    )
    expect(note).to be_valid
  end

  # メッセージが無ければ無効な状態であること
  it "is invalid without a message." do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include("can't be blank")
  end


  describe "search message for a term" do
    before do
      @note1 = @project.notes.create(message: "This is the first note.", user: @user,)
      @note2 = @project.notes.create(message: "This is the second note.", user: @user,)
      @note3 = @project.notes.create(message: "First, preheat the oven.", user: @user,)
      @note4 = @project.notes.create(message: "First, kore ha nihon no note.", user: @user,)
    end

    context "when a match is found" do
      # 一致する場合の examples
      # 検索文字列　に一致するメモを返すこと
      it "returns notes that match the search term" do
        expect(Note.search("first")).to include(@note1, @note3)
        expect(Note.search("first")).to_not include(@note2)
      end
    end

    context "when no match is found" do
      # 一致しない場合の examples
      # 検索結果が１件も見つからなければ空のコレクションを返すこと
      it "returns an empty collection" do
        expect(Note.search("message")).to be_empty
      end
    end
  end

# describe "クラスやシステムの機能に関するアウトライン" do
#   context "特定の状態に関するアウトライン" do
#     # examples
#   end
# end
end
