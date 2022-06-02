#include "ItemMapCollection.hpp"

ItemMapCollection::SetMap(CollectionKey& key, ItemMap& map) {
    m_Collection->insert_or_assign(key, map);
}
ItemMapCollection::GetItemMap(CollectionKey& key) {
    return m_Collection->at(key);
}