require 'rails_helper'

RSpec.describe CoursesController, type: :controller do


  describe "Homepage" do
    it "route root path to course # index" do
      expect(get: "/").to route_to(controller: "courses", action: "index")
    end
  end

  describe "GET index" do
    it "assigns @courses" do

      course1 = FactoryGirl.create(:course)
      course2 = FactoryGirl.create(:course)

      get :index

      expect(assigns[:courses]).to eq([course1, course2])
      
    end

    it "render template" do
      course1 = FactoryGirl.create(:course)
      course2 = FactoryGirl.create(:course)

      get :index

      expect(response).to render_template("index")
    end

  end


  describe "GET show" do
    it "assigns @course" do

      course = FactoryGirl.create(:course)

      get :show, params: {id: course.id}

      expect(assigns[:course]).to eq(course)
      
    end

    it "render template" do
      course = FactoryGirl.create(:course)

      get :show, params: {id: course.id}
      
      expect(response).to render_template("show")
    end

  end


  describe "GET new" do
    it "assigns @course" do

      course = FactoryGirl.build(:course)

      get :new

      expect(assigns[:course]).to be_new_record
      expect(assigns[:course]).to be_instance_of(Course)
    end

    it "render template" do
      course = FactoryGirl.build(:course)

      get :new
      
      expect(response).to render_template("new")
    end
  end



  describe "POST create" do

    context "when course doesn't have a title" do
      it "doesn't create a record" do
        expect{ post :create, params: { course: {description: "bar"} } }.to change{ Course.count }.by(0)
      end

      it "render new template" do
        post :create, params: {course: {description: "bar"}}
        expect(response).to render_template("new")
      end
    end

    
    context "when course has a title" do
      it "create a new course record" do
        course = FactoryGirl.build(:course)
        expect{ post :create, params: {course: FactoryGirl.attributes_for(:course)} }.to change{ Course.count }.by(1)
      end


      it "redirect to courses_path" do
        course = FactoryGirl.build(:course)
        post :create, params: { course: FactoryGirl.attributes_for(:course) }
        expect(response).to redirect_to courses_path
      end
    end

  end


  describe "GET edit" do
    it "assigns course" do
      course = FactoryGirl.create(:course)
      get :edit, params: {id: course.id}
      expect(assigns[:course]).to eq(course)
    end

    it "render template" do
      course = FactoryGirl.create(:course)
      get :edit, params: {id: course.id}
      expect(assigns[:course]).to eq(course)
    end
  end


  describe "PUT update" do

    context "when course has title" do
      it "assigns @course" do
        course = FactoryGirl.create(:course)
        put :update, params: {id: course.id, course: { title: "Title", description: "Description"}}
        expect(assigns[:course]).to eq(course)
      end

      it "changes value" do
        course = FactoryGirl.create(:course)
        put :update, params: {id: course.id, course: { title: "Title", description: "Description"}}
        expect(assigns[:course].title).to eq("Title")
        expect(assigns[:course].description).to eq("Description")
      end

      it "redirect_to course_path" do
        course = FactoryGirl.create(:course)
        put :update, params: {id: course.id, course: { title: "Title", description: "Description"}}
        expect(response).to redirect_to course_path(course)
      end
    end

    context "when course doesn't have title" do
      it "assigns @course" do
        course = FactoryGirl.create(:course)
        put :update, params: {id: course.id, course: { title: "", description: "Description"}}
        expect(assigns[:course]).not_to eq("Description")
      end

      it "render edit template" do
        course = FactoryGirl.create(:course)
        put :update, params: {id: course.id, course: { title: "", description: "Description"}}
        expect(response).to render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "assigns @course" do
      course = FactoryGirl.create(:course)
      delete :destroy, params: { id: course.id }
      expect(assigns[:course]).to eq(course)
    end

    it "delete a record" do
      course = FactoryGirl.create(:course)
      expect{ delete :destroy, params: { id: course.id } }.to change{ Course.count }.by(-1)
    end

    it "redirect to courses_path" do
      course = FactoryGirl.create(:course)
      delete :destroy, params: { id: course.id }
      expect(response).to redirect_to courses_path
    end
  end

end
