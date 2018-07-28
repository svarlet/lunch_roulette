defmodule Domain.SubmitRestaurant.LoggerFeedbackTest do
  use ExUnit.Case, async: true

  alias Domain.Restaurant
  alias Domain.SubmitRestaurant.Feedback
  alias Domain.SubmitRestaurant.Feedback.LoggerFeedback

  test "report_success returns :ok" do
    logger_feedback = %LoggerFeedback{}
    restaurant = %Restaurant{name: Faker.Company.name()}
    assert :ok == Feedback.report_success(logger_feedback, restaurant)
  end
end
