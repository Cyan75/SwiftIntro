#include <unordered_map>

#include "ItemMap.hpp"

typedef unsigned int CollectionKey;
typedef std::unordered_map<CollectionKey, ItemMap> Collection;

class ItemMapCollection {
   private:
    Collection* m_Collection;

   public:
    ItemMapCollection() {}
    void SetMap(CollectionKey& key, ItemMap& map);
    ItemMap GetItemMap(CollectionKey& key);
};