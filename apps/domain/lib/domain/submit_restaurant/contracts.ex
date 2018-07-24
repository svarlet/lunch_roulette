defprotocol Domain.SubmitRestaurant.Validator do
  alias Domain.Restaurant

  @type validator :: any

  @type result ::
          {:ok, Restaurant.t()}
          | {:error, :nil_submission}
          | {:error, :nil_restaurant_name}
          | {:error, :empty_restaurant_name}

  @spec validate(validator, Restaurant.t()) :: result
  def validate(validator, restaurant)
end

defprotocol Domain.SubmitRestaurant.Shortlist do
  alias Domain.Restaurant

  @type shortlist :: any
  @type result :: {:ok, shortlist} | {:error, :already_shortlisted}

  @spec put_in(shortlist, Restaurant.t()) :: result
  def put_in(shortlist, restaurant)
end

defprotocol Domain.SubmitRestaurant.Feedback do
  alias Domain.Restaurant

  @type feedback :: any

  @spec report_success(feedback, Restaurant.t()) :: no_return
  def report_success(feedback, restaurant)

  @spec report_already_shortlisted(feedback, Restaurant.t()) :: no_return
  def report_already_shortlisted(feedback, restaurant)

  @spec report_invalid_submission(feedback, Restaurant.t()) :: no_return
  def report_invalid_submission(feedback, restaurant)
end
