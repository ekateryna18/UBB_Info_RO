package repository;

import model.Admin;

public interface IAdminRepo extends Repository<Integer,Admin>{
    Admin authentificate(String username, String password);
}
