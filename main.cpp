#include <iostream>
#include <salome/MEDCouplingUMesh.hxx>
#include <salome/MEDCouplingMemArray.hxx>
#include <salome/MEDCouplingFieldDouble.hxx>
#include <salome/MEDLoader.hxx>

using namespace ParaMEDMEM;

int main()
{
    const int nNodes = 4;
    const int dim = 2;
    const double coordsRaw[] = {0.0,0.0, 2.0,0.0, 2.0,2.0, 0.0,2.0};
    const int connRaw[] = {0,1,2,3};

    MEDCouplingUMesh* mesh = MEDCouplingUMesh::New();
    mesh->setMeshDimension(dim);
    mesh->setName("test_mesh");
    mesh->allocateCells(1);
    mesh->insertNextCell(INTERP_KERNEL::NORM_QUAD4, 4, &connRaw[0]);

    DataArrayDouble* coords = DataArrayDouble::New();
    coords->useArray(coordsRaw, false, CPP_DEALLOC, nNodes, dim);
    coords->setInfoOnComponent(0, "x [m]");
    coords->setInfoOnComponent(1, "y [m]");
    mesh->setCoords(coords);

    MEDLoader::WriteUMesh("mesh.med", mesh, true);

    DataArrayDouble* uArray = DataArrayDouble::New();
    uArray->alloc(nNodes, 1);
    uArray = coords->applyFunc(1, "x*y");
    MEDCouplingFieldDouble* uField = MEDCouplingFieldDouble::New(ON_NODES, ONE_TIME);
    uField->setName("u");
    uField->setMesh(mesh);
    uField->setArray(uArray);

    DataArrayDouble* vArray = DataArrayDouble::New();
    vArray->alloc(nNodes, 2);
    vArray = coords->applyFunc(2, "x*IVec + y*JVec");
    MEDCouplingFieldDouble* vField = MEDCouplingFieldDouble::New(ON_NODES, ONE_TIME);
    vField->setName("v");
    vField->setMesh(mesh);
    vField->setArray(vArray);

    std::vector<const MEDCouplingFieldDouble*> field_list(2);
    field_list[0] = uField;
    field_list[1] = vField;
    MEDCouplingFieldDouble::WriteVTK("test.vtu", field_list);

    return 0;
}
