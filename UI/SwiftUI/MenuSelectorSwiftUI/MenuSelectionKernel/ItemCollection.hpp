#include <unordered_map>

#include "Item.hpp"

typedef unsigned int Key;
typedef std::unordered_map<Key, Item> Collection;
class ItemCollection {
   private:
    Collection *m_collection;

   public:
    ItemContainer() {}
    void SetItem(Key &key, Item &item());
    Item GetItem(Key &key);
    auto GetCollectionSize();
};