#include "ItemCollection.hpp"
void ItemCollection::SetItem(Key &key, Item &item()) {
    m_collection->insert_or_assign(key, item);
}
Item ItemCollection::GetItem(Key &key) {
    return m_collection->at(key);
}