defmodule AccountsHelpers do
  defmacro __using__(_options) do
    quote do
      import AccountsHelpers, only: :functions
    end
  end

  # A private function that allows to create fake strings with a defined length (only lowercase letters currently)
  @spec random_string(integer) :: binary
  def random_string(length) do
    letters = String.graphemes("abcdefghijklmnopqrstuvwxyz")
    Stream.repeatedly(fn -> Enum.random(letters) end) |> Enum.take(length) |> Enum.join()
  end


    # A private function that creates fake string that represent numbers of a given length.
  # It is not an Integer but a String
  def random_number_string(length) do
    numbers = String.graphemes("0123456789")
    Stream.repeatedly(fn -> Enum.random(numbers) end) |> Enum.take(length) |> Enum.join()
  end



  @doc """
  A function to create a unique user email for tests
  It works creating a random string of 10 characters and then appending @test.com at the end of it
  """
  @spec unique_user_email :: <<_::64, _::_*8>>
  def unique_user_email, do: "#{AccountsHelpers.random_string(10)}@test.com"

  @doc """
  A function to create a valid password, that can be used in tests.
  It always returns the same password, to allow for easy comparisons.
  """
  def valid_user_password, do: "Hello world!"

  @doc """
   A function that returns a valid user name, with a list of valid names
  """
  def valid_user_name, do: ~w{ Sergio Paco Pedro Juan Alicia Sara Rosa Clara } |> Enum.random()

  @doc """
  A function that returns a valid user surname, basically generating a random first surname <space> second surname
  """
  def valid_user_surname, do: "#{AccountsHelpers.random_string(8)} #{AccountsHelpers.random_string(6)}"

  @doc """
  A function that returns a valid user telephone, with a valid prefix, and 8 numbers afterwards
  It allows to test numbers in the format:
  +[country code][valid_first_digit][8 random_digits]
  [valid_first_digit][8 random digits]
  """
  def valid_user_telephone,
    do: (["+346", "6", "+349", "9", "+348", "8"] |> Enum.random()) <> random_number_string(8)

end
