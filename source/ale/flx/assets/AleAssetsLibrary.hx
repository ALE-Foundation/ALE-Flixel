package ale.flx.assets;

import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import openfl.utils.AssetType;

import lime.media.AudioBuffer;
import lime.graphics.Image;
import lime.utils.Assets;
import lime.utils.Bytes;
import lime.text.Font;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import haxe.io.Path;

class AleAssetsLibrary extends AssetLibrary
{
    public final roots:Array<String>;

    var caches(get, never):Array<Dynamic>;
    function get_caches():Array<Map<String, Dynamic>>
        return [cachedAudioBuffers, cachedBytes, cachedFonts, cachedImages, cachedText];

    public function new(roots:Array<String>)
    {
        this.roots = roots.filter(r -> r != null);

        super();

        final proxy = Assets.getLibrary('default');
        
        classTypes = proxy.classTypes.copy();

        cachedAudioBuffers = proxy.cachedAudioBuffers.copy();
        cachedBytes = proxy.cachedBytes.copy();
        cachedFonts = proxy.cachedFonts.copy();
        cachedImages = proxy.cachedImages.copy();
        cachedText = proxy.cachedText.copy();
    }

    override public function exists(id:String, _:String):Bool
        return getPath(id) != null || getEmbedPath(id) != null || getCachedPath(id) != null;

    override public function getPath(uPath:String):String
    {
        #if sys
        for (root in roots)
        {
            final path = Path.join([root, uPath]);

            if (FileSystem.exists(path))
                return path;
        }

        return AleFile.insensitiveSearch(uPath);
        #else
        return null;
        #end
    }

    public function getEmbedPath(uPath:String):String
    {
        for (root in roots)
        {
            final path = Path.join([root, uPath]);

            if (classTypes.exists(path))
                return path;
        }

        return null;
    }

    public function getCachedPath(uPath:String, ?map:Map<String, Dynamic>):AleAssetsLibraryCache
    {
        for (root in roots)
        {
            final path = Path.join([root, uPath]);

            if (map == null)
            {
                for (cache in caches)
                {
                    if (cache.exists(path))
                        return {
                            cache: cache,
                            path: path
                        };
                }
            } else if (map.exists(path))
                return {
                    cache: map,
                    path: path
                };
        }

        return null;
    }

    public function getEmbed(id:String):Dynamic
    {
        final path:String = getEmbedPath(id);

        return path == null ? null : Type.createInstance(classTypes[path], []);
    }

    public function getCached(id:String, ?map:Map<String, Dynamic>):Dynamic
    {
        final path = getCachedPath(id, map);

        return path == null ? null : path.cache[path.path];
    }


    override public function getBytes(id:String):Bytes
    {
        #if sys
        final path = getPath(id);

        if (path != null)
            return File.getBytes(path);
        #end
        
        return getEmbed(id) ?? getCached(id, cachedBytes);
    }

    override public function getText(id:String):String
    {
        #if sys
        final path = getPath(id);

        if (path != null)
            return File.getContent(path);
        #end

        return getEmbed(id) ?? getCached(id, cachedText);
    }

    override public function getAudioBuffer(id:String):AudioBuffer
    {
        final bytes = getBytes(id);

        return bytes == null ? getCached(id, cachedAudioBuffers) : AudioBuffer.fromBytes(bytes);
    }

    override public function getImage(id:String):Image
    {
        #if sys
        final path = getPath(id);

        if (path != null)
            return Image.fromBytes(File.getBytes(path));
        #end

        return getEmbed(id) ?? getCached(id, cachedImages);
    }

    override public function getFont(id:String):Font
    {
        #if sys
        final path = getPath(id);

        if (path != null)
            return Font.fromBytes(File.getBytes(path));
        #end

        return getEmbed(id) ?? getCached(id, cachedFonts);
    }

    override public function getAsset(id:String, type:String):Dynamic
        return switch (cast type)
        {
            case BINARY:
                getBytes(id);

            case TEXT:
                getText(id);

            case IMAGE:
                getImage(id);
                
            case SOUND, MUSIC:
                getAudioBuffer(id);

            case FONT:
                getFont(id);
            default:
                null;
        }
}

typedef AleAssetsLibraryCache = {
    cache:Map<String, Dynamic>,
    path:String
}