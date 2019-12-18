class TitleBracketsValidator < ActiveModel::Validator
  def validate (movie)
    title = movie.title

    # Checking for empty brackets
    unless ['()', '[]', '{}'].none? { |b| title.include?(b) }
      movie.errors.add(:title, "contains empty brackets")
      return false
    end

    # Checking for lone and incorrect placement brackets
    open_brackets = ['(', '{', '[']
    close_brackets = [')', '}', ']']
    stack = []

    open_brackets.each_with_index do |bracket, index|
      open_count = 0
      close_count = 0

      title.each_char do |char|
        if char == bracket
          open_count += 1
          stack.push(char)
        elsif char == close_brackets[index]
          close_count += 1
          last = stack.pop
          if last != open_brackets[close_brackets.index(char)]
            movie.errors.add(:title, "is not valid title")
            return false
          end
        end
      end
      movie.errors.add(:title, "contains lone brackets") if open_count != close_count
    end
    movie.errors.add(:title, "is not valid title") unless stack.empty?
  end
end