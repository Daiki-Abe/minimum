module DumpsHelper
  def link_to_index_dump
    link_to "投稿一覧に戻る", dumps_path, class: "move-index__btn"
  end
end
