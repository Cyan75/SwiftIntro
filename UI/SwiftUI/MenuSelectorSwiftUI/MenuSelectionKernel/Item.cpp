#include "Item.hpp"

void Item::SetName(Name &newName) {
    m_name = &newName;
}

Name Item::GetName() {
    return *m_name;
}