ExUnit.start()

defmodule Domain.SubmitRestaurant.Shortlist.Mock do
  alias Domain.SubmitRestaurant.Shortlist

  defstruct [:put_in_result]

  defimpl Shortlist do
    def put_in(shortlist_mock, restaurant) do
      send self(), {:put_in, shortlist_mock, restaurant}
      shortlist_mock.put_in_result
    end
  end
end

defmodule Domain.SubmitRestaurant.Validator.Mock do
  alias Domain.SubmitRestaurant.Validator

  defstruct [:validate_result]

  defimpl Validator do
    def validate(validator, restaurant) do
      send self(), {:validate, validator, restaurant}
      validator.validate_result
    end
  end
end

defmodule Domain.SubmitRestaurant.Feedback.Mock do
  alias Domain.SubmitRestaurant.Feedback

  defstruct []

  defimpl Feedback do
    def report_success(feedback, restaurant) do
      send self(), {:report_success, feedback, restaurant}
    end

    def report_already_shortlisted(feedback, restaurant) do
      send self(), {:report_already_shortlisted, feedback, restaurant}
    end

    def report_invalid_submission(feedback, restaurant) do
      send self(), {:report_invalid_submission, feedback, restaurant}
    end
  end
end
