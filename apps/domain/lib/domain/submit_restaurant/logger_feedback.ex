defmodule Domain.SubmitRestaurant.Feedback.LoggerFeedback do
  defstruct []

  alias Domain.SubmitRestaurant.Feedback

  defimpl Feedback do
    def report_success(_logger_feedback, _restaurant) do
      :ok
    end

    def report_already_shortlisted(_feedback, _restaurant) do
      -1
    end

    def report_invalid_submission(_feedback, _restaurant) do
      -1
    end
  end
end
