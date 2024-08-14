import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recruitment_management_system/api/api.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  static int _adminCounter = 1;

  static const String userDbFileName = 'user.db';
  Future createDbPath() async {
    final String databaseFilePath;
    Directory databasePath = await getApplicationDocumentsDirectory();
    databaseFilePath = join(databasePath.path, userDbFileName);
    return databaseFilePath;
  }

  Future getDataBaseFile() async {
    final File file = File(await createDbPath());
    return file.path;
  }

  initializeDatabase() async {
    Database db = await openDatabase(
      await getDataBaseFile(),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE ADMIN(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          userid INTEGER,
          name VARCHAR(50),
          contact VARCHAR(10),
          email VARCHAR(50),
          address VARCHAR(100),
          designation TEXT(10),
          password VARCHAR(20)
          )
          ''');
        print("USER Table Created");
        await db.execute('''CREATE TABLE RECRUITMENT(
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          recruitment_number VARCHAR(10),
          first_name TEXT(20),
          last_name TEXT(20),
          email VARCHAR(50),
          phone VARCHAR(20),
          street VARCHAR(50),
          city VARCHAR(30),
          state VARCHAR(30),
          postal_code VARCHAR(20),
          gender TEXT(6),
          recruitment_status VARCHAR(20),
          applied_designation VARCHAR(10)
          )
          ''');
        print("RECRUITMENT Table Created");
      },
    );
    return db;
  }

  Future<Database> getDatabase() async {
    Database db = await initializeDatabase();
    return db;
  }

  Future<bool> isDatabaseInitialized() async {
    final filePath = await getDataBaseFile();
    return File(filePath).exists();
  }


  Future<bool> checkLoginCredentials(String email, String password) async {
    final Database db = await getDatabase();
    var result = await db.rawQuery('SELECT * FROM ADMIN WHERE email = ? AND password = ?', [email, password]);
    return result.isNotEmpty;
  }

  // Default Admin
  Future<void> addAdmin() async {
    final Database db = await getDatabase();
    String userid = 'admin${_adminCounter.toString().padLeft(3, '0')}';
    _adminCounter++;
    Map<String, dynamic> adminDetails = {
      'userid': userid,
      'name': 'Himanshu Jeena',
      'contact': '9599209518',
      'email': 'himanshujeena9718@gmail.com',
      'address': 'Vijay Nagar GZB',
      'designation': 'Admin',
      'password': 'Jeena9718@',
    };
    try {
      await db.insert('ADMIN', adminDetails);
      print('Admin detail added successfully of $userid');
    } catch (e) {
      print('Error adding admin detail: $e');
    }
  }

  // Add Mor ADMIN's to ADMIN Table
  Future<void> insertAdmin(String email, String username, String password, String phone) async {
    final Database db = await getDatabase();
    String userid = 'admin${_adminCounter.toString().padLeft(3, '0')}';
    _adminCounter++;
    await db.insert(
      'ADMIN',
      {
        'userid':userid,
        'email': email,
        'name': username,
        'password': password,
        'contact': phone,
      },
    );
  }


  Future<void> addCandidates(List<Candidates> candidates) async {
    final Database db = await getDatabase();
    Batch batch = db.batch();
    for (var candidate in candidates) {
      batch.insert(
        'RECRUITMENT',
        {
          'recruitment_number': candidate.recruitmentNumber,
          'first_name': candidate.firstName,
          'last_name': candidate.lastName,
          'email': candidate.email,
          'phone': candidate.phone,
          'street': candidate.street,
          'city': candidate.city,
          'state': candidate.state,
          'postal_code': candidate.postalCode,
          'gender': candidate.gender,
          'recruitment_status': candidate.recruitmentStatus,
          'applied_designation': candidate.appliedDesignation,
        },
      );
    }
    await batch.commit();
  }

  Future<void> storeDataInDatabase() async {
    List<Candidates> apidata = await DataService().getData();
    final AppDataBase appDatabase = AppDataBase();
    await appDatabase.addCandidates(apidata);
    await appDatabase.addAdmin();
  }

  // Fetch the Active Candidates from recruitment table
  Future<List<Candidates>> showActiveCandidateList() async {
    Database _dbClient = await getDatabase();
    List<Map<String, dynamic>> dbdata = await _dbClient.rawQuery("""
    SELECT * FROM RECRUITMENT 
    WHERE recruitment_status IN ('new', 'in_progress')
  """);
    List<Candidates> list = dbdata.map((map) => Candidates.fromJson(map)).toList();
    print("Active candidates fetched successfully..........");
    return list;
  }


  // Fetch the Inactive Candidates from recruitment table
  Future<List<Candidates>> showInActiveCandidateList() async {
    Database _dbClient = await getDatabase();
    List<Map<String, dynamic>> dbdata = await _dbClient.rawQuery("""
    SELECT * FROM RECRUITMENT 
    WHERE recruitment_status IN ('rejected', 'selected')
  """);
    List<Candidates> list = dbdata.map((map) => Candidates.fromJson(map)).toList();
    print("InActive candidates fetched successfully..........");
    return list;
  }


// Fetch the number of candidates status as count
  Future<Map<String, double>> getRecruitmentStatusCount() async {
    Database _dbClient = await getDatabase();
    List<Map<String, dynamic>> dbdata = await _dbClient.rawQuery("""
    SELECT recruitment_status, COUNT(*) as count 
    FROM RECRUITMENT 
    GROUP BY recruitment_status
  """);

    Map<String, double> statusCountMap = {};
    for (var data in dbdata) {
      statusCountMap[data['recruitment_status']] = data['count'].toDouble();
    }
    return statusCountMap;
  }

 // fetch number of candidates by gender count
  Future<Map<String, double>> getCandidatesByGenderCount() async {
    Database _dbClient = await getDatabase();
    List<Map<String, dynamic>> dbdata = await _dbClient.rawQuery("""
    SELECT gender, COUNT(*) as count 
    FROM RECRUITMENT 
    GROUP BY gender
  """);
    print(dbdata);

    Map<String, double> genderCountMap = {};
    for (var data in dbdata) {
      genderCountMap[data['gender']] = data['count'].toDouble();
    }
    print(genderCountMap);
    return genderCountMap;
  }

// Fetch the number of candidates by designation count
  Future<Map<String, double>> getCandidatesByDesignationCount() async {
    Database _dbClient = await getDatabase();
    List<Map<String, dynamic>> dbdata = await _dbClient.rawQuery("""
    SELECT applied_designation, COUNT(*) as count 
    FROM RECRUITMENT 
    GROUP BY applied_designation
  """);

    Map<String, double> designationCountMap = {};
    for (var data in dbdata) {
      designationCountMap[data['applied_designation']] = data['count'].toDouble();
    }
    print(designationCountMap);
    return designationCountMap;
  }


  // update the status of the candidate
  Future<void> updateCandidateStatus(String? recruit_number, String newStatus) async {
    Database _dbClient = await getDatabase();
    await _dbClient.rawUpdate("""
    UPDATE RECRUITMENT
    SET recruitment_status = ?
    WHERE recruitment_number = ?
  """, [newStatus,recruit_number ]);
    print("Candidate status updated successfully..........");
  }
}
