module IndexShotgun
  module ArrayStartWith
    refine Array do
      def start_with?(target_array)
        return false if self.length < target_array.length

        target_array.each_with_index do |target_element, index|
          return false unless self.at(index) == target_element
        end

        true
      end
    end
  end
end
