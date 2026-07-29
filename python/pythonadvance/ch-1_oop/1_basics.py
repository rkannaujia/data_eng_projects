class MyClass:
    var1=10;
    var2=20;
    
    def addition(self):
        return self.var1 + self.var2;
    def subtraction(self):
        return self.var2-self.var1;
    
obj1 =MyClass();
print(obj1.addition());
obj2 = MyClass();
print(obj2.subtraction());