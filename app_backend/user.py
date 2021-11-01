class User():

    """
    User keeps track of the quack app users balanace information

    name: str
        The name of the user

    dooley_dollars: float
        The current balance of dooley dollars

    meal_swipes: int
        The current amount of remaining meal swipes

    """

    def __init__(self, UUID, dooley_dollars, meal_swipes):
        self.name = UUID  # will change to user ID after future refactoring and development
        self.meal_swipes = meal_swipes  # Meal swipe quanity
        self.dooley_dollars = dooley_dollars  # Dooley Dollar Balance
