package ale.flx.assets;

import sys.FileSystem;
import sys.io.File;

import haxe.io.Path;

using StringTools;

class AleFile
{
	public static inline function sanitize(path:String):String
		return path.trim().toLowerCase().replace(' ', '-');

    public static function readDirectory(path:String):Array<String>
    {
        final result:Array<String> = FileSystem.readDirectory(path);
        
        result.sort((a, b) -> return Reflect.compare(a, b));

        return result;
    }

    public static function insensitiveSearch(uPath:String, ?keepRoot:Bool = true):String
    {
        final route:Array<String> = Path.normalize(uPath).split('/').filter(s -> s.length > 0);

        if (route.length == 0)
            return null;

        for (root in AleAssets.library.roots)
        {
            if (!FileSystem.exists(root))
                continue;

            var currentPath:String = root;

            var matchFound:Bool = true;

            for (index => dir in route)
            {
                if (!FileSystem.isDirectory(currentPath))
                {
                    matchFound = false;
                    
                    break;
                }

                final targetSanitized:String = AleFile.sanitize(dir);

                var nextSegment:String = null;

                for (entry in FileSystem.readDirectory(currentPath))
                    if (AleFile.sanitize(entry) == targetSanitized)
                    {
                        nextSegment = entry;

                        break;
                    }

                if (nextSegment == null)
                {
                    matchFound = false;

                    break;
                }

                currentPath = Path.join([currentPath, nextSegment]);
            }

            if (matchFound && FileSystem.exists(currentPath))
                return keepRoot ? currentPath : Path.join(route);
        }

        return null;
    }
}
