module TVDB
  module Responses
    class Actor < Abstract
      private

      def _key_crosswalk
        {
          id: :tvdb_actor_id
        }
      end
    end
  end
end
