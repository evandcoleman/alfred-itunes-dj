module DACPClient
  class Playlists < Model
    dmap_tag :aply
    dmap_attribute :status, :mstt
    dmap_attribute :update_type, :myty
    dmap_attribute :container_count, :mtco
    dmap_attribute :returned_count, :mrco
    dmap_container :items, :mlcl, DACPClient::Playlist
  end
end
