using System;

class main1
{
    static void Main()
    {
        // การประกาศตัวแปรแบบ implicit
        var number = 10; // int
        var message = "Hello"; // string
        var pi = 3.14; // double

        // แสดงประเภทของตัวแปร
        Console.WriteLine(number.GetType()); // Output: System.Int32
        Console.WriteLine(message.GetType()); // Output: System.String
        Console.WriteLine(pi.GetType()); // Output: System.Double

        // การประกาศตัวแปรแบบ dynamic
        dynamic dynamicValue = 10;
        Console.WriteLine(dynamicValue.GetType()); // Output: System.Int32

        dynamicValue = "Hello";
        Console.WriteLine(dynamicValue.GetType()); // Output: System.String
    }
}
