package ale.flixel.assets;

import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import openfl.utils.AssetType;

import lime.media.AudioBuffer;
import lime.graphics.Image;
import lime.utils.Bytes;
import lime.text.Font;

import sys.FileSystem;
import sys.io.File;

import haxe.io.Path;

class AleAssetsLibrary extends AssetLibrary
{
    public final roots:Array<String>;

    public function new(roots:Array<String>)
    {
        this.roots = roots.filter(r -> r != null);

        super();

        __fromManifest(AssetManifest.fromFile('manifest/default.json'));
    }

    override public function exists(id:String, type:String):Bool
        return getPath(id) != null || getEmbedPath(id) != null;

    override public function getPath(uPath:String):String
    {
        for (root in roots)
        {
            final path = Path.join([root, uPath]);

            if (FileSystem.exists(path))
                return path;
        }

        return AleFile.insensitiveSearch(uPath);
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

    public inline function embedInstance(id):Dynamic
        return Type.createInstance(classTypes[id], []);

    override public function getBytes(id:String):Bytes
    {
        final path = getPath(id);

        if (path != null)
            return File.getBytes(path);
        
        final ePath = getEmbedPath(id);

        if (ePath != null)
            return embedInstance(ePath);

        return null;
    }

    override public function getText(id:String):String
    {
        final path = getPath(id);

        if (path != null)
            return File.getContent(path);

        final ePath = getEmbedPath(id);

        if (ePath != null)
            return embedInstance(ePath);

        return null;
    }

    override public function getAudioBuffer(id:String):AudioBuffer
    {
        final bytes:Bytes = getBytes(id);

        return bytes == null ? null : AudioBuffer.fromBytes(bytes);
    }

    override public function getImage(id:String):Image
    {
        final path = getPath(id);

        if (path != null)
            return Image.fromBytes(File.getBytes(path));

        final ePath = getEmbedPath(id);

        if (ePath != null)
            return embedInstance(ePath);

        return null;
    }

    override public function getFont(id:String):Font
    {
        final path = getPath(id);

        if (path != null)
            return Font.fromBytes(File.getBytes(path));

        final ePath = getEmbedPath(id);

        if (ePath != null)
            return embedInstance(ePath);

        return null;
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
                super.getAsset(id, type);
        }
}
