class OpenLevel
  CLOSED=0
  LIST_ONLY=1
  READ_ONLY=2
  OPEN=99

  def self.options
    [['비공개', CLOSED], ['목록보기', LIST_ONLY], ['내용보기', READ_ONLY], ['읽고쓰기', OPEN]]
  end
  
  def self.level(level)
    options.find { |option| option.last == level }.first
  end
end