#include "ItemMap.hpp"
void ItemMap::SetItem(Key &key, Item &item()) {
    m_Map->insert_or_assign(key, item);
}
Item ItemMap::GetItem(Key &key) {
    return m_Map->at(key);
}
auto ItemMap::GetMapSize() {
    return m_Map->size();
}