class Car:
    # Constructor
    def __init__(self, brand, model, color, fuel):
        self.brand = brand
        self.model = model
        self.color = color
        self.fuel = fuel
        self.speed = 0
        self.is_started = False

    # Method to start the car
    def start(self):
        if self.fuel > 0:
            self.is_started = True
            print(f"{self.brand} {self.model} has started.")
        else:
            print("Cannot start the car. Fuel tank is empty.")

    # Method to accelerate
    def accelerate(self, increase):
        if self.is_started:
            self.speed += increase
            print(f"Car is now running at {self.speed} km/h.")
        else:
            print("Please start the car first.")

    # Method to apply brakes
    def brake(self, decrease):
        self.speed = max(0, self.speed - decrease)
        print(f"Car speed is now {self.speed} km/h.")

    # Method to refuel
    def refuel(self, litres):
        self.fuel += litres
        print(f"Added {litres} litres of fuel.")
        print(f"Current fuel: {self.fuel} litres.")

    # Method to display car details
    def display_info(self):
        print("\nCar Details")
        print(f"Brand : {self.brand}")
        print(f"Model : {self.model}")
        print(f"Color : {self.color}")
        print(f"Fuel  : {self.fuel} litres")
        print(f"Speed : {self.speed} km/h")

car1 = Car("Toyota", "Fortuner", "Black", 20)
car2 = Car("Honda", "City", "White", 15)

car1.start()
car1.accelerate(30)
car1.brake(10)
car1.refuel(10)
car1.display_info()

car2.start()
car2.accelerate(25)
car2.brake(5)
car2.refuel(15)
car2.display_info()