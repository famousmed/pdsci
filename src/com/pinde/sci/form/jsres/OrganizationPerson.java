package com.pinde.sci.form.jsres;

import java.io.Serializable;

public class OrganizationPerson  implements Serializable{
			/**
	 * 
	 */
	private static final long serialVersionUID = -3524388431912961659L;
			private String name;
			private String  sex;
			private String age;
			private String profession;
			private String tallStudy;
			private String dept;
			private String job;
			private String partOrAllJob;
			private String telephone;
			public String getName() {
				return name;
			}
			public void setName(String name) {
				this.name = name;
			}
			public String getSex() {
				return sex;
			}
			public void setSex(String sex) {
				this.sex = sex;
			}
			public String getAge() {
				return age;
			}
			public void setAge(String age) {
				this.age = age;
			}
			public String getProfession() {
				return profession;
			}
			public void setProfession(String profession) {
				this.profession = profession;
			}
			public String getTallStudy() {
				return tallStudy;
			}
			public void setTallStudy(String tallStudy) {
				this.tallStudy = tallStudy;
			}
			public String getDept() {
				return dept;
			}
			public void setDept(String dept) {
				this.dept = dept;
			}
			public String getJob() {
				return job;
			}
			public void setJob(String job) {
				this.job = job;
			}
			public String getPartOrAllJob() {
				return partOrAllJob;
			}
			public void setPartOrAllJob(String partOrAllJob) {
				this.partOrAllJob = partOrAllJob;
			}
			public String getTelephone() {
				return telephone;
			}
			public void setTelephone(String telephone) {
				this.telephone = telephone;
			}
}
