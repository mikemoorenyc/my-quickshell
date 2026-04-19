pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.util
Singleton {
    id:menuData
    property string menuRaw:""
    property var menus:[]
    property string slug: ShellContext.launcherMenuSlug
    property var currentMenu: menus.find(m => m.slug ===ShellContext.launcherMenuSlug)
    property var backMenu: menus.find(m => m.slug ==ShellContext.launcherMenuBackSlug)
    onSlugChanged :{
        rawGrabber.reload()
    }
    FileView {
        id: rawGrabber
        path: "/home/admin/.config/my-quickshell/configs/menus.txt"
        onFileChanged: reload()
        onLoaded: {
            menuRaw = this.text()
            menus = getMenus(this.text().toString())
            
           // currentMenu = findMenu(menus,ShellContext.launcherMenuSlug)
            
        }
    }
    function getMenus(menuRaw) {
            if(!menuRaw) return []
        const menuSplit = menuRaw.split("\n\n").filter(n=>n.trim().length > 1)
        const menus = menuSplit.map(m=> {
            const rows = m.split("\n")
            const title = rows.find(r=>r.startsWith("title:"))?.replace("title:","").trim()||""
            const slug = rows.find(r => r.startsWith("slug:"))?.replace("slug:","").trim()||""
            let items = rows.filter(r=>!r.startsWith("slug:")&&!r.startsWith("title:"))
            items = items.map(r => r.split(",").map(i=>i.trim()))
            items = items.map(i => {
                return {
                    title: i[0],
                    exec:i[1],
                    icon:i[2]||undefined
                }
            })
        
            return {title,slug,items}
        })
        return menus
        }
   
        function findMenu(menus,slug) {
          
            return menus.find(m => m.slug ===slug)
        }
}
