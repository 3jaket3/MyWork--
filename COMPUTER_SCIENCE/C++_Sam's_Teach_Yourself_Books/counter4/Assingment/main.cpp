#include <iostream>

using namespace std;

class Trycicle
{
public:
    Trycicle();
    //copy constructor and destructor and default
    int getSpeed() const {return *speed;}
    void setSpeed(int newSpeed) { *speed = newSpeed; }
    Trycicle operator=(const Trycicle&);
private:
    int *speed;
};
Trycicle::Trycicle()
{
    speed = new int;
    *speed = 5;
}

Trycicle Trycicle::operator=(const Trycicle& rhs)
{
    if (this == &rhs)
    return *this;

    delete speed;
    speed = new int;
    *speed = rhs.getSpeed();
    return *this;
}

int main()
{
    Trycicle wichita;
    std::cout << "Wichita's speed: " << wichita.getSpeed() << "\n";
    std::cout << "setting wichitas speed to 6...\n";
    wichita.setSpeed(6);
    Trycicle dallas;
    std::cout << "Dallas' speed: " << dallas.getSpeed() << "\n";

    std::cout << "dallas speed: " << dallas.getSpeed() << "\n";
    wichita = dallas;
    std::cout << "Dallas' speed: " << dallas.getSpeed() << "\n";
    return 0;

}
