#include <string>
typedef std::string Name;
class Item {
   private:
    Name *m_name;

   public:
    Item(Name &name) : m_name(&name) {}
    void SetName(Name &newName);
    Name GetName();
};