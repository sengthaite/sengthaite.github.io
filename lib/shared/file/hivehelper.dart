import 'package:hive/hive.dart';
import 'package:sengthaite_blog/shared/file/hivedir.dart';

class HiveAPIDirService {
  final String _boxName = "API_DIR";

  Future<Box<TempDir>> get _box async => await Hive.openBox<TempDir>(_boxName);

  Future<TempDir?> findDir(String dirname) async {
    var box = await _box;
    return box.get(dirname);
  }

  // create new dir
  Future<void> newDir(TempDir dir) async {
    String dirname = dir.dirname;
    var existingDir = await findDir(dirname);
    if (existingDir != null) {
      throw "EXISTING DIRECTORY";
    }
    var box = await _box;
    await box.put(dirname, dir);
  }

  // read
  Future<List<TempDir>> getAllDirs() async {
    var box = await _box;
    return box.values.toList();
  }

  // update by index
  Future<void> updateDirByIndex(int index, TempDir dir) async {
    var box = await _box;
    await box.putAt(index, dir);
  }

  // update by name
  Future<void> updateDirByName(String name, TempDir dir) async {
    var box = await _box;
    await box.put(name, dir);
  }

  // delete by index
  Future<void> deleteDirByIndex(int index) async {
    var box = await _box;
    box.deleteAt(index);
  }

  // delete by name
  Future<void> deleteDirByName(String name) async {
    var box = await _box;
    box.delete(name);
  }
}
