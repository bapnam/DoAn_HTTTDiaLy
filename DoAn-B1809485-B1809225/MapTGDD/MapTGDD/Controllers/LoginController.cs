using MapTGDD.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MapTGDD.Controllers
{
    public class LoginController : Controller
    {
        Model_MapTGDDEntities db = new Model_MapTGDDEntities();
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(NguoiDung user)
		{
            var r = db.NguoiDungs.Where(u => u.MaND == user.MaND && u.MatKhau == user.MatKhau);

            if (r.Count() > 0)
            {
                return RedirectToAction("Index", "Home");
               
            }
            ModelState.AddModelError("", "Tên đăng nhập hoặc mật khẩu không đúng");
            return View("Index");
        }


    }
}