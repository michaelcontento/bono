class ObjectCompare
{
public:
    int static Compare(Object* left, Object* right)
    {
        return left->Compare(right);
    }
};
