class Collection
attr_reader :companies
  def initialize(array_of_ids)
    @companies = array_of_ids.map { |id| Company.new(id.to_s).standardize_id_length(8) }
  end





end