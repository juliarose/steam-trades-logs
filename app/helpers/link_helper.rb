module LinkHelper
  
    def reptf_link(steamid)
        link_to steamid,
            "https://rep.tf/#{steamid}",
            target: '_blank'
    end
  end
  